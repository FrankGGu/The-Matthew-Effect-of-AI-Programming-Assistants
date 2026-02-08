import java.util.*;

class Solution {
    private static final int MOD = 1_000_000_007;

    public int rectangleArea(int[][] rectangles) {
        // 1. Collect unique y-coordinates
        Set<Integer> ySet = new TreeSet<>();
        for (int[] rect : rectangles) {
            ySet.add(rect[1]); // y1
            ySet.add(rect[3]); // y2
        }
        List<Integer> yCoords = new ArrayList<>(ySet);
        Map<Integer, Integer> yMap = new HashMap<>();
        for (int i = 0; i < yCoords.size(); i++) {
            yMap.put(yCoords.get(i), i);
        }

        // 2. Create events
        List<Event> events = new ArrayList<>();
        for (int[] rect : rectangles) {
            int x1 = rect[0];
            int y1 = rect[1];
            int x2 = rect[2];
            int y2 = rect[3];

            // Only consider rectangles with positive area (x1 < x2 and y1 < y2 are guaranteed by constraints)
            events.add(new Event(x1, yMap.get(y1), yMap.get(y2), 1));
            events.add(new Event(x2, yMap.get(y1), yMap.get(y2), -1));
        }

        // Sort events by x-coordinate. If x-coordinates are the same, process 'start' events (+1) before 'end' events (-1).
        Collections.sort(events);

        // 3. Initialize Segment Tree
        // The segment tree operates on intervals between y-coordinates.
        // If yCoords has M elements, there are M-1 intervals.
        // The indices for these intervals are 0 to M-2.
        SegmentTree segmentTree = new SegmentTree(yCoords);

        // 4. Sweep Line
        long totalArea = 0;
        long prevX = events.get(0).x;

        for (Event event : events) {
            long currentX = event.x;
            int y1Idx = event.y1Idx;
            int y2Idx = event.y2Idx; // This is the index of y2 itself, not the end of interval index
            int type = event.type;

            // Add area of the strip (prevX to currentX)
            // The height of the strip is segmentTree.getTotalCoveredLength()
            // The width is (currentX - prevX)
            totalArea = (totalArea + (segmentTree.getTotalCoveredLength() * (currentX - prevX))) % MOD;

            // Update segment tree for the current event
            // A rectangle from y1 (index y1Idx) to y2 (index y2Idx) covers intervals
            // from y1_idx up to (but not including) y2_idx.
            // In terms of segment tree indices, this corresponds to [y1_idx, y2_idx - 1].
            segmentTree.update(0, 0, yCoords.size() - 2, y1Idx, y2Idx - 1, type);
            // The first `0` is for the root node index in the tree array.
            // The `0` and `yCoords.size() - 2` define the full range of intervals the tree covers.

            prevX = currentX;
        }

        return (int) totalArea;
    }

    private static class SegmentTree {
        private Node[] tree;
        private List<Integer> yCoords;
        private int N_Y_INTERVALS; // Number of intervals, which is yCoords.size() - 1

        private static class Node {
            int count; // Number of active rectangles covering this segment
            long totalLength; // Total length of covered sub-segments within this node's range

            public Node() {
                count = 0;
                totalLength = 0;
            }
        }

        public SegmentTree(List<Integer> yCoords) {
            this.yCoords = yCoords;
            this.N_Y_INTERVALS = yCoords.size() - 1;

            // If there are 0 or 1 unique y-coordinates, there are no intervals to manage.
            // The problem constraints (y1 < y2) ensure N_Y_INTERVALS >= 1.
            if (N_Y_INTERVALS <= 0) { 
                this.tree = null; // No tree needed
                return;
            }
            this.tree = new Node[4 * N_Y_INTERVALS]; // Array for implicit tree structure
            for (int i = 0; i < tree.length; i++) {
                tree[i] = new Node();
            }
        }

        // idx: current node's index in tree array
        // rangeStartIdx: start index of y_coords for this node's segment (e.g., if node covers [y_coords[a], y_coords[b+1]], this is 'a')
        // rangeEndIdx: end index of y_coords for this node's segment (e.g., if node covers [y_coords[a], y_coords[b+1]], this is 'b')
        // updateStartIdx: start index of y_coords for the update range
        // updateEndIdx: end index of y_coords for the update range (inclusive)
        // delta: +1 for adding a rectangle, -1 for removing
        public void update(int idx, int rangeStartIdx, int rangeEndIdx, int updateStartIdx, int updateEndIdx, int delta) {
            if (N_Y_INTERVALS <= 0) return; // No intervals to update

            // Case 1: No overlap between current node's range and update range
            if (rangeStartIdx > updateEndIdx || rangeEndIdx < updateStartIdx) {
                return;
            }

            // Case 2: Current node's range is completely contained within the update range
            if (updateStartIdx <= rangeStartIdx && rangeEndIdx <= updateEndIdx) {
                tree[idx].count += delta;
            } else { // Case 3: Partial overlap
                int mid = rangeStartIdx + (rangeEndIdx - rangeStartIdx) / 2;
                update(2 * idx + 1, rangeStartIdx, mid, updateStartIdx, updateEndIdx, delta); // Left child
                update(2 * idx + 2, mid + 1, rangeEndIdx, updateStartIdx, updateEndIdx, delta); // Right child
            }

            // Recalculate totalLength for the current node after (potential) children updates
            if (tree[idx].count > 0) {
                // If this node is covered by at least one active rectangle, its entire corresponding y-length is active
                tree[idx].totalLength = yCoords.get(rangeEndIdx + 1) - yCoords.get(rangeStartIdx);
            } else {
                // If not covered by any active rectangle itself:
                if (rangeStartIdx == rangeEndIdx) { // It's a leaf node
                    tree[idx].totalLength = 0; // No children, and not covered, so length is 0
                } else { // It's an internal node
                    // Its total length is the sum of its children's covered lengths
                    tree[idx].totalLength = tree[2 * idx + 1].totalLength + tree[2 * idx + 2].totalLength;
                }
            }
        }

        public long getTotalCoveredLength() {
            if (N_Y_INTERVALS <= 0) return 0;
            return tree[0].totalLength; // The root node (index 0) holds the total covered length for the entire y-range
        }
    }

    private static class Event implements Comparable<Event> {
        int x;
        int y1Idx; // Index in yCoords list for y1
        int y2Idx; // Index in yCoords list for y2
        int type;  // +1 for rectangle start, -1 for rectangle end

        public Event(int x, int y1Idx, int y2Idx, int type) {
            this.x = x;
            this.y1Idx = y1Idx;
            this.y2Idx = y2Idx;
            this.type = type;
        }

        @Override
        public int compareTo(Event other) {
            if (this.x != other.x) {
                return Integer.compare(this.x, other.x);
            }
            // If x-coordinates are the same, process 'start' events (+1) before 'end' events (-1).
            // This ensures that when a rectangle starts and another ends at the same x,
            // the starting rectangle's y-interval is added to the active set *before*
            // we calculate the area for the strip ending at this x.
            // Then, for the next strip, the ending rectangle's y-interval is removed.
            return Integer.compare(this.type, other.type);
        }
    }
}