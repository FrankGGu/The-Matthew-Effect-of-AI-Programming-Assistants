import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

class CountIntervals {

    private TreeMap<Integer, Integer> intervals; // Stores [start, end]
    private long totalCount; // Stores the total number of integers in all intervals

    public CountIntervals() {
        intervals = new TreeMap<>();
        totalCount = 0;
    }

    public void add(int left, int right) {
        long currentLeft = left;
        long currentRight = right;

        // Step 1: Check for an interval that precedes 'left' and overlaps/touches [left, right]
        // intervals.floorEntry(left) finds the entry with the greatest key <= left.
        // If this entry's end value is >= left - 1, it overlaps or touches.
        Map.Entry<Integer, Integer> prevEntry = intervals.floorEntry(left);
        if (prevEntry != null && prevEntry.getValue() >= left - 1) {
            currentLeft = Math.min(currentLeft, prevEntry.getKey());
            currentRight = Math.max(currentRight, prevEntry.getValue());
            totalCount -= (prevEntry.getValue() - prevEntry.getKey() + 1); // Subtract length of merged interval
            intervals.remove(prevEntry.getKey()); // Remove the old interval
        }

        // Step 2: Collect all subsequent intervals that overlap or touch the potentially extended [currentLeft, currentRight]
        // The subMap method returns a view of the portion of this map whose keys range from fromKey, inclusive, to toKey, exclusive.
        // We need to check keys up to currentRight + 1 to account for touching intervals.
        // So, the range for keys is [currentLeft, currentRight + 1].
        // The `toKey` for subMap should be `(int)currentRight + 2` to make it exclusive.
        List<Integer> keysToRemove = new ArrayList<>();
        for (Map.Entry<Integer, Integer> entry : intervals.subMap((int)currentLeft, true, (int)currentRight + 2, false).entrySet()) {
            currentRight = Math.max(currentRight, entry.getValue()); // Extend currentRight
            keysToRemove.add(entry.getKey()); // Mark interval for removal
        }

        // Step 3: Remove the collected intervals and update totalCount
        for (Integer key : keysToRemove) {
            totalCount -= (intervals.get(key) - key + 1); // Subtract length of removed interval
            intervals.remove(key);
        }

        // Step 4: Add the new merged interval and update totalCount
        intervals.put((int)currentLeft, (int)currentRight);
        totalCount += (currentRight - currentLeft + 1);
    }

    public int count() {
        return (int) totalCount;
    }
}