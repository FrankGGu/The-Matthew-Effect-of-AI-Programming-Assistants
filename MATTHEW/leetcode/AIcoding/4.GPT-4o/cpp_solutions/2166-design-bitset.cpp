class Bitset {
public:
    vector<bool> bits;
    int count;
    bool flipped;

    Bitset(int size) : bits(size, false), count(0), flipped(false) {}

    void fix(int idx) {
        if (flipped) {
            if (!bits[idx]) {
                bits[idx] = true;
                count++;
            }
        } else {
            if (bits[idx] == false) {
                bits[idx] = true;
                count++;
            }
        }
    }

    void unfix(int idx) {
        if (flipped) {
            if (bits[idx]) {
                bits[idx] = false;
                count--;
            }
        } else {
            if (bits[idx]) {
                bits[idx] = false;
                count--;
            }
        }
    }

    void flip() {
        flipped = !flipped;
        count = bits.size() - count;
    }

    bool all() {
        return count == bits.size();
    }

    bool one() {
        return count > 0;
    }

    int countSetBits() {
        return count;
    }

    string toString() {
        string result;
        for (bool bit : bits) {
            result += (bit ^ flipped) ? '1' : '0';
        }
        return result;
    }
};