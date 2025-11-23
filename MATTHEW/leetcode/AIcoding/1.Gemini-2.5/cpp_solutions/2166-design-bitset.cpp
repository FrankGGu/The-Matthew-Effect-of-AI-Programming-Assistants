#include <string>
#include <vector>
#include <numeric>

class Bitset {
private:
    std::string bits;
    int sz;
    int ones_count;
    bool is_flipped;

public:
    Bitset(int size) {
        this->sz = size;
        bits.assign(size, '0');
        ones_count = 0;
        is_flipped = false;
    }

    void fix(int idx) {
        char original_char = bits[idx];
        if (!is_flipped) {
            if (original_char == '0') {
                bits[idx] = '1';
                ones_count++;
            }
        } else {
            if (original_char == '1') {
                bits[idx] = '0';
                ones_count++;
            }
        }
    }

    void unfix(int idx) {
        char original_char = bits[idx];
        if (!is_flipped) {
            if (original_char == '1') {
                bits[idx] = '0';
                ones_count--;
            }
        } else {
            if (original_char == '0') {
                bits[idx] = '1';
                ones_count--;
            }
        }
    }

    void flip() {
        is_flipped = !is_flipped;
        ones_count = sz - ones_count;
    }

    bool all() {
        return ones_count == sz;
    }

    bool one() {
        return ones_count > 0;
    }

    int count() {
        return ones_count;
    }

    std::string toString() {
        if (!is_flipped) {
            return bits;
        }
        std::string flipped_bits = bits;
        for (char &c : flipped_bits) {
            c = (c == '0' ? '1' : '0');
        }
        return flipped_bits;
    }
};