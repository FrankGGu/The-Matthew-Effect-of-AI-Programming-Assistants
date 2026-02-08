class Allocator {
    private int[] memory;
    private int size;

    public Allocator(int n) {
        memory = new int[n];
        size = n;
    }

    public int allocate(int size, int mID) {
        int count = 0, start = -1;
        for (int i = 0; i < this.size; i++) {
            if (memory[i] == 0) {
                if (count == 0) start = i;
                count++;
                if (count == size) {
                    for (int j = start; j < start + size; j++) {
                        memory[j] = mID;
                    }
                    return start;
                }
            } else {
                count = 0;
                start = -1;
            }
        }
        return -1;
    }

    public int free(int mID) {
        int freed = 0;
        for (int i = 0; i < size; i++) {
            if (memory[i] == mID) {
                memory[i] = 0;
                freed++;
            }
        }
        return freed;
    }
}