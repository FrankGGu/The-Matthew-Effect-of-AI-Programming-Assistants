class LUPrefix {
private:
    vector<bool> uploaded;
    int prefix;
    int n;

public:
    LUPrefix(int n) {
        uploaded.resize(n + 2, false);
        prefix = 0;
        this->n = n;
    }

    void upload(int video) {
        uploaded[video] = true;
        while (prefix + 1 <= n && uploaded[prefix + 1]) {
            prefix++;
        }
    }

    int longest() {
        return prefix;
    }
};