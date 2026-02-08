class Allocator {
private:
    vector<int> memory;
    int total;

public:
    Allocator(int n) {
        memory.resize(n, 0);
        total = n;
    }

    int allocate(int size, int mID) {
        int start = 0;
        while (start < total) {
            if (memory[start] == 0) {
                int end = start;
                while (end < total && memory[end] == 0 && end - start + 1 <= size) {
                    end++;
                }
                if (end - start == size) {
                    for (int i = start; i < end; ++i) {
                        memory[i] = mID;
                    }
                    return start;
                } else {
                    start = end;
                }
            } else {
                start++;
            }
        }
        return -1;
    }

    int free(int mID) {
        int count = 0;
        for (int i = 0; i < total; ++i) {
            if (memory[i] == mID) {
                memory[i] = 0;
                count++;
            }
        }
        return count;
    }
};