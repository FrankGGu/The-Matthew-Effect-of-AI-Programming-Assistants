#include <string>
#include <vector>

class Bitset {
private:
    std::vector<bool> bits;
    int size;
    int count;

public:
    Bitset(int size) : size(size), count(0), bits(size, false) {}

    void fix(int idx) {
        if (!bits[idx]) {
            bits[idx] = true;
            count++;
        }
    }

    void unfix(int idx) {
        if (bits[idx]) {
            bits[idx] = false;
            count--;
        }
    }

    void flip() {
        for (int i = 0; i < size; ++i) {
            bits[i] = !bits[i];
        }
        count = size - count;
    }

    bool all() {
        return count == size;
    }

    bool one() {
        return count > 0;
    }

    int count_() {
        return count;
    }

    std::string toString() {
        std::string result = "";
        for (int i = 0; i < size; ++i) {
            result += (bits[i] ? '1' : '0');
        }
        return result;
    }
};