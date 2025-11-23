import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class MemAllocator {
    private int n;
    private int[] memory;
    private Map<Integer, List<int[]>> allocatedBlocks;

    public MemAllocator(int n) {
        this.n = n;
        this.memory = new int[n];
        this.allocatedBlocks = new HashMap<>();
    }

    public int allocate(int size, int mID) {
        int currentFreeCount = 0;
        int startIndex = -1;

        for (int i = 0; i < n; i++) {
            if (memory[i] == 0) {
                currentFreeCount++;
                if (currentFreeCount == 1) {
                    startIndex = i;
                }
            } else {
                currentFreeCount = 0;
                startIndex = -1;
            }

            if (currentFreeCount == size) {
                for (int j = startIndex; j < startIndex + size; j++) {
                    memory[j] = mID;
                }
                allocatedBlocks.computeIfAbsent(mID, k -> new ArrayList<>()).add(new int[]{startIndex, size});
                return startIndex;
            }
        }
        return -1;
    }

    public int free(int mID) {
        if (!allocatedBlocks.containsKey(mID)) {
            return 0;
        }

        List<int[]> blocksToFree = allocatedBlocks.get(mID);
        int freedCount = 0;

        for (int[] block : blocksToFree) {
            int start = block[0];
            int size = block[1];
            for (int i = start; i < start + size; i++) {
                memory[i] = 0;
            }
            freedCount += size;
        }

        allocatedBlocks.remove(mID);
        return freedCount;
    }
}