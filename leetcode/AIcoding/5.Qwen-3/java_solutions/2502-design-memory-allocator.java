public class Allocator {
    private int[] memory;
    private int size;

    public Allocator(int n) {
        memory = new int[n];
        size = n;
    }

    public int allocate(int size, int idx) {
        for (int i = idx; i < size + idx; i++) {
            if (i >= memory.length || memory[i] != 0) {
                return -1;
            }
        }
        for (int i = idx; i < size + idx; i++) {
            memory[i] = 1;
        }
        return idx;
    }

    public int free(int start, int end) {
        int count = 0;
        for (int i = start; i <= end; i++) {
            if (i < memory.length && memory[i] == 1) {
                memory[i] = 0;
                count++;
            }
        }
        return count;
    }
}