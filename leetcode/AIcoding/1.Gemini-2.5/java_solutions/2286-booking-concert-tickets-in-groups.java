class ConcertTickets {

    private long N_ROWS;
    private long M_SEATS;
    private long current_row_ptr = 0; // The first row to consider for book operations

    private Node root;

    // Helper class for Segment Tree Node
    private class Node {
        Node left, right;
        long minSeatsTaken; // Minimum seats taken in any row in this node's range
        long sumAvailableSeats; // Sum of (M_SEATS - seatsTaken[i]) for rows in this node's range

        public Node() {
            // Default constructor for root, minSeatsTaken is 0, sumAvailableSeats is calculated based on range
            this.minSeatsTaken = 0; 
            this.sumAvailableSeats = 0; // Will be set by parent or during initialization of a specific range
        }
    }

    public ConcertTickets(long n, long m) {
        N_ROWS = n;
        M_SEATS = m;
        // The root node represents the entire range of rows [0, N_ROWS-1]
        root = new Node();
        root.minSeatsTaken = 0;
        root.sumAvailableSeats = N_ROWS * M_SEATS; // Initially all seats available
    }

    // --- Segment Tree Helper Methods ---

    // Update operation: Set seats_taken for a specific row
    private void update(Node node, long nodeRangeStart, long nodeRangeEnd, long targetRow, long newSeatsTaken) {
        if (nodeRangeStart == nodeRangeEnd) { // Leaf node
            node.minSeatsTaken = newSeatsTaken;
            node.sumAvailableSeats = M_SEATS - newSeatsTaken;
            return;
        }

        long mid = nodeRangeStart + (nodeRangeEnd - nodeRangeStart) / 2;

        if (targetRow <= mid) {
            if (node.left == null) {
                node.left = new Node();
                node.left.minSeatsTaken = 0; // Initially 0 seats taken in this new child's range
                node.left.sumAvailableSeats = (mid - nodeRangeStart + 1) * M_SEATS; // All seats available
            }
            update(node.left, nodeRangeStart, mid, targetRow, newSeatsTaken);
        } else {
            if (node.right == null) {
                node.right = new Node();
                node.right.minSeatsTaken = 0; // Initially 0 seats taken in this new child's range
                node.right.sumAvailableSeats = (nodeRangeEnd - (mid + 1) + 1) * M_SEATS; // All seats available
            }
            update(node.right, mid + 1, nodeRangeEnd, targetRow, newSeatsTaken);
        }

        // Recalculate parent's values
        long leftMinSeatsTaken = (node.left != null) ? node.left.minSeatsTaken : 0;
        long rightMinSeatsTaken = (node.right != null) ? node.right.minSeatsTaken : 0;
        node.minSeatsTaken = Math.min(leftMinSeatsTaken, rightMinSeatsTaken);

        long leftSumAvailable = (node.left != null) ? node.left.sumAvailableSeats : (mid - nodeRangeStart + 1) * M_SEATS;
        long rightSumAvailable = (node.right != null) ? node.right.sumAvailableSeats : (nodeRangeEnd - (mid + 1) + 1) * M_SEATS;
        node.sumAvailableSeats = leftSumAvailable + rightSumAvailable;
    }

    // Query for book(k): Find the first row in [queryMinRow, N_ROWS-1] that has at least `k` available seats
    // i.e., find first row `r` such that `seats_taken[r] <= M_SEATS - k`
    private long findFirstRowForBook(Node node, long nodeRangeStart, long nodeRangeEnd, long queryMinRow, long maxSeatsTakenAllowed) {
        // If node is null, or its range is outside query range, or no row in its range can satisfy the condition
        if (node == null || nodeRangeStart > N_ROWS - 1 || nodeRangeEnd < queryMinRow || node.minSeatsTaken > maxSeatsTakenAllowed) {
            return -1;
        }

        if (nodeRangeStart == nodeRangeEnd) { // Leaf node
            return nodeRangeStart;
        }

        long mid = nodeRangeStart + (nodeRangeEnd - nodeRangeStart) / 2;

        // Search in left child if it exists and potentially has a solution
        // Also ensure the left child's range overlaps with the queryMinRow
        if (node.left != null && node.left.minSeatsTaken <= maxSeatsTakenAllowed && queryMinRow <= mid) {
            long res = findFirstRowForBook(node.left, nodeRangeStart, mid, queryMinRow, maxSeatsTakenAllowed);
            if (res != -1) {
                return res;
            }
        }

        // Search in right child if it exists and potentially has a solution
        // Also ensure the right child's range overlaps with the queryMinRow
        if (node.right != null && node.right.minSeatsTaken <= maxSeatsTakenAllowed && queryMinRow <= nodeRangeEnd) {
            long res = findFirstRowForBook(node.right, mid + 1, nodeRangeEnd, queryMinRow, maxSeatsTakenAllowed);
            if (res != -1) {
                return res;
            }
        }

        return -1; // No row found in this node's range
    }

    // Query for scatter(k, maxRow): Find and book `seatsToBook` seats in rows [0, queryMaxRow]
    // Returns the number of seats actually booked.
    private long findAndBookScatter(Node node, long nodeRangeStart, long nodeRangeEnd, long queryMaxRow, long seatsToBook) {
        // If node is null, or its range is outside query range, or no seats left, or no seats to book
        if (node == null || nodeRangeStart > queryMaxRow || nodeRangeEnd < 0 || node.sumAvailableSeats == 0 || seatsToBook == 0) {
            return 0;
        }

        if (nodeRangeStart == nodeRangeEnd) { // Leaf node
            long seatsInThisRow = M_SEATS - node.minSeatsTaken;
            long booked = Math.min(seatsInThisRow, seatsToBook);
            node.minSeatsTaken += booked; // Update seats taken
            node.sumAvailableSeats -= booked; // Update available seats
            return booked;
        }

        long mid = nodeRangeStart + (nodeRangeEnd - nodeRangeStart) / 2;
        long booked = 0;

        // Prioritize left child (lower rows)
        if (node.left != null && nodeRangeStart <= queryMaxRow) { // Check if left child's range overlaps with query range
            booked += findAndBookScatter(node.left, nodeRangeStart, mid, queryMaxRow, seatsToBook);
        }

        // If more seats are needed, try right child
        if (booked < seatsToBook && node.right != null && mid + 1 <= queryMaxRow) { // Check if right child's range overlaps
            booked += findAndBookScatter(node.right, mid + 1, nodeRangeEnd, queryMaxRow, seatsToBook - booked);
        }

        // Recalculate parent's values after children updates
        long leftMinSeatsTaken = (node.left != null) ? node.left.minSeatsTaken : 0;
        long rightMinSeatsTaken = (node.right != null) ? node.right.minSeatsTaken : 0;
        node.minSeatsTaken = Math.min(leftMinSeatsTaken, rightMinSeatsTaken);

        long leftSumAvailable = (node.left != null) ? node.left.sumAvailableSeats : (mid - nodeRangeStart + 1) * M_SEATS;
        long rightSumAvailable = (node.right != null) ? node.right.sumAvailableSeats : (nodeRangeEnd - (mid + 1) + 1) * M_SEATS;
        node.sumAvailableSeats = leftSumAvailable + rightSumAvailable;

        return booked;
    }

    // Helper to get current seats taken for a specific row.
    private long getSeatsTaken(Node node, long nodeRangeStart, long nodeRangeEnd, long targetRow) {
        if (node == null) { 
            return 0; // If node is null, it means 0 seats taken in this range
        }
        if (nodeRangeStart == nodeRangeEnd) { // Leaf node
            return node.minSeatsTaken;
        }
        long mid = nodeRangeStart + (nodeRangeEnd - nodeRangeStart) / 2;
        if (targetRow <= mid) {
            return getSeatsTaken(node.left, nodeRangeStart, mid, targetRow);
        } else {
            return getSeatsTaken(node.right, mid + 1, nodeRangeEnd, targetRow);
        }
    }

    // --- Public API Methods ---

    public long[] book(int k) {
        long targetRow = findFirstRowForBook(root, 0, N_ROWS - 1, current_row_ptr, M_SEATS - k);

        if (targetRow == -1) {
            return new long[]{};
        }

        long currentSeatsTakenInRow = getSeatsTaken(root, 0, N_ROWS - 1, targetRow);

        long startSeat = currentSeatsTakenInRow;
        update(root, 0, N_ROWS - 1, targetRow, currentSeatsTakenInRow + k);

        // If the booked row was the current_row_ptr and it became full, advance current_row_ptr
        if (targetRow == current_row_ptr && currentSeatsTakenInRow + k == M_SEATS) {
            current_row_ptr = findFirstRowForBook(root, 0, N_ROWS - 1, current_row_ptr + 1, M_SEATS - 1);
            if (current_row_ptr == -1) { // No more rows with available seats
                current_row_ptr = N_ROWS; 
            }
        }

        return new long[]{targetRow, startSeat};
    }

    public int scatter(int k, int maxRow) {
        long bookedSeats = findAndBookScatter(root, 0, N_ROWS - 1, maxRow, k);

        // After scatter, current_row_ptr needs to be re-evaluated to point to the smallest indexed non-full row.
        current_row_ptr = findFirstRowForBook(root, 0, N_ROWS - 1, 0, M_SEATS - 1);
        if (current_row_ptr == -1) {
            current_row_ptr = N_ROWS; // All rows are full
        }

        return (int) bookedSeats;
    }
}