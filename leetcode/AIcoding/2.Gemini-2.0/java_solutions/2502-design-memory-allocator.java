class Allocator {
    int[] memory;
    int size;

    public Allocator(int n) {
        memory = new int[n];
        size = n;
    }

    public int allocate(int size, int mID) {
        for (int i = 0; i <= this.size - size; i++) {
            boolean found = true;
            for (int j = 0; j < size; j++) {
                if (memory[i + j] != 0) {
                    found = false;
                    break;
                }
            }
            if (found) {
                for (int j = 0; j < size; j++) {
                    memory[i + j] = mID;
                }
                return i;
            }
        }
        return -1;
    }

    public int free(int mID) {
        int count = 0;
        for (int i = 0; i < size; i++) {
            if (memory[i] == mID) {
                memory[i] = 0;
                count++;
            }
        }
        return count;
    }
}