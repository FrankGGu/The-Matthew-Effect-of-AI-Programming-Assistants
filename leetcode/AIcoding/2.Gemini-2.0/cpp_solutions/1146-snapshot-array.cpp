#include <vector>
#include <map>

using namespace std;

class SnapshotArray {
public:
    SnapshotArray(int length) : snap_id_(0) {
        data_.resize(length);
        for (int i = 0; i < length; ++i) {
            data_[i][0] = 0;
        }
    }

    void set(int index, int val) {
        data_[index][snap_id_] = val;
    }

    int snap() {
        return snap_id_++;
    }

    int get(int index, int snap_id) {
        auto it = data_[index].upper_bound(snap_id);
        if (it == data_[index].begin()) {
            return 0;
        }
        return (--it)->second;
    }

private:
    vector<map<int, int>> data_;
    int snap_id_;
};