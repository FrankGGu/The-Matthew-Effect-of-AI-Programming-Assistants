import java.util.*;

class Solution {

    // Fenwick Tree (BIT) implementation
    static class BIT {
        int[] tree;
        int N; // Size of the compressed range (max index + 1)

        public BIT(int size) {
            this.N = size;
            tree = new int[N + 1]; // 1-indexed array for BIT operations
        }

        // Add val to the element at original 0-indexed position 'idx'
        public void update(int idx, int val) {
            idx++; // Convert to 1-indexed for Fenwick tree
            while (idx <= N) {
                tree[idx] += val;
                idx += idx & (-idx);
            }
        }

        // Get sum of elements from original 0-indexed position 0 to 'idx'
        public int query(int idx) {
            if (idx < 0) return 0; // Handle queries for indices before 0
            idx++; // Convert to 1-indexed for Fenwick tree
            int sum = 0;
            while (idx > 0) {
                sum += tree[idx];
                idx -= idx & (-idx);
            }
            return sum;
        }
    }

    public int[] countRectangles(int[][] rectangles, int[][] points) {
        // 1. Coordinate compression for x-coordinates (lengths of rectangles and x-coordinates of points)
        TreeSet<Integer> allXCoords = new TreeSet<>();
        for (int[] rect : rectangles) {
            allXCoords.add(rect[0]);
        }
        for (int[] point : points) {
            allXCoords.add(point[0]);
        }

        List<Integer> compressedX = new ArrayList<>(allXCoords);
        Map<Integer, Integer> xToCompressedIdx = new HashMap<>();
        for (int i = 0; i < compressedX.size(); i++) {
            xToCompressedIdx.put(compressedX.get(i), i);
        }
        int bitSize = compressedX.size();

        // 2. Prepare points with original indices and sort them by y-coordinate in descending order
        List<int[]> sortedPoints = new ArrayList<>();
        for (int i = 0; i < points.length; i++) {
            sortedPoints.add(new int[]{points[i][0], points[i][1], i}); // {x, y, original_index}
        }
        Collections.sort(sortedPoints, (a, b) -> b[1] - a[1]); // Sort by y-coordinate descending

        // 3. Sort rectangles by height (h) in descending order
        Arrays.sort(rectangles, (a, b) -> b[1] - a[1]); // Sort by h-coordinate descending

        // 4. Initialize result array and Fenwick Tree
        int[] ans = new int[points.length];
        BIT bit = new BIT(bitSize);
        int rectIdx = 0; // Pointer for sorted rectangles

        // 5. Sweep-line approach
        for (int[] point : sortedPoints) {
            int x_j = point[0];
            int y_j = point[1];
            int original_idx_j = point[2];

            // Add rectangles whose height h_i is greater than or equal to current point's y_j
            while (rectIdx < rectangles.length && rectangles[rectIdx][1] >= y_j) {
                int l_i = rectangles[rectIdx][0];
                int compressed_l_i = xToCompressedIdx.get(l_i);
                bit.update(compressed_l_i, 1);
                rectIdx++;
            }

            // Query the BIT for count of rectangles satisfying l_i >= x_j
            int compressed_x_j_idx = xToCompressedIdx.get(x_j);
            // Count elements from compressed_x_j_idx to bitSize - 1
            // This is total count in BIT minus count of elements less than compressed_x_j_idx
            int count = bit.query(bitSize - 1) - bit.query(compressed_x_j_idx - 1);
            ans[original_idx_j] = count;
        }

        return ans;
    }
}