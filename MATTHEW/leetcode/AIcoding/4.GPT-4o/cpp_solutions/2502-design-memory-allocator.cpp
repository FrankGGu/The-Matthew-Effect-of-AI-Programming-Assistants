class Allocator {
public:
    vector<int> memory;
    int size;

    Allocator(int n) {
        size = n;
        memory = vector<int>(n, -1);
    }

    int allocate(int size) {
        for (int i = 0; i <= this->size - size; i++) {
            bool canAllocate = true;
            for (int j = 0; j < size; j++) {
                if (memory[i + j] != -1) {
                    canAllocate = false;
                    break;
                }
            }
            if (canAllocate) {
                for (int j = 0; j < size; j++) {
                    memory[i + j] = i;
                }
                return i;
            }
        }
        return -1;
    }

    int free(int start, int size) {
        if (start < 0 || start >= this->size || memory[start] != start) {
            return 0;
        }
        int count = 0;
        for (int i = 0; i < size; i++) {
            if (start + i < this->size && memory[start + i] == start) {
                memory[start + i] = -1;
                count++;
            }
        }
        return count;
    }

    int getFragmentedMemory() {
        int fragmentCount = 0;
        for (int i = 0; i < size; i++) {
            if (memory[i] == -1) {
                fragmentCount++;
            }
        }
        return fragmentCount;
    }
};