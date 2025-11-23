class Bitset {
private:
    vector<int> bits;
    int cnt;
    bool flipped;

public:
    Bitset(int size) {
        bits.resize(size, 0);
        cnt = 0;
        flipped = false;
    }

    void fix(int idx) {
        if (!flipped) {
            if (bits[idx] == 0) {
                bits[idx] = 1;
                cnt++;
            }
        } else {
            if (bits[idx] == 1) {
                bits[idx] = 0;
                cnt++;
            }
        }
    }

    void unfix(int idx) {
        if (!flipped) {
            if (bits[idx] == 1) {
                bits[idx] = 0;
                cnt--;
            }
        } else {
            if (bits[idx] == 0) {
                bits[idx] = 1;
                cnt--;
            }
        }
    }

    void flip() {
        flipped = !flipped;
        cnt = bits.size() - cnt;
    }

    bool all() {
        return cnt == bits.size();
    }

    bool one() {
        return cnt > 0;
    }

    int count() {
        return cnt;
    }

    string toString() {
        string res;
        for (int bit : bits) {
            if (!flipped) {
                res += bit ? '1' : '0';
            } else {
                res += bit ? '0' : '1';
            }
        }
        return res;
    }
};