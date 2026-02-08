#include <vector>
#include <numeric>

class Allocator {
private:
    std::vector<int> memory;
    int N;

public:
    Allocator(int n) {
        N = n;
        memory.resize(n, 0);
    }

    int allocate(int size, int mID) {
        for (int i = 0; i <= N - size; ++i) {
            bool can_allocate = true;
            for (int j = 0; j < size; ++j) {
                if (memory[i + j] != 0) {
                    can_allocate = false;
                    i = i + j;
                    break;
                }
            }
            if (can_allocate) {
                for (int j = 0; j < size; ++j) {
                    memory[i + j] = mID;
                }
                return i;
            }
        }
        return -1;
    }

    int free(int mID) {
        int freed_count = 0;
        for (int i = 0; i < N; ++i) {
            if (memory[i] == mID) {
                memory[i] = 0;
                freed_count++;
            }
        }
        return freed_count;
    }
};