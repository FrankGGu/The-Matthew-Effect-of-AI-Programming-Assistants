class SnapshotArray {
private:
    vector<map<int, int>> snaps;
    int snap_id;

public:
    SnapshotArray(int length) {
        snaps.resize(length);
        snap_id = 0;
        for (int i = 0; i < length; ++i) {
            snaps[i][0] = 0;
        }
    }

    void set(int index, int val) {
        snaps[index][snap_id] = val;
    }

    int snap() {
        return snap_id++;
    }

    int get(int index, int snap_id) {
        auto it = snaps[index].upper_bound(snap_id);
        if (it == snaps[index].begin()) return 0;
        --it;
        return it->second;
    }
};