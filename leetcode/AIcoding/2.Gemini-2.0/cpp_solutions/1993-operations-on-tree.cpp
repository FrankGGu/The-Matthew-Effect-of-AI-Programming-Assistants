#include <vector>

using namespace std;

class LockingTree {
public:
    vector<int> parent;
    vector<int> lockStatus;
    vector<vector<int>> children;

    LockingTree(vector<int>& parent) {
        this->parent = parent;
        int n = parent.size();
        lockStatus.resize(n, 0);
        children.resize(n);
        for (int i = 1; i < n; ++i) {
            children[parent[i]].push_back(i);
        }
    }

    bool lock(int num, int user) {
        if (lockStatus[num] == 0) {
            lockStatus[num] = user;
            return true;
        }
        return false;
    }

    bool unlock(int num, int user) {
        if (lockStatus[num] == user) {
            lockStatus[num] = 0;
            return true;
        }
        return false;
    }

    bool upgrade(int num, int user) {
        if (lockStatus[num] != 0) return false;

        int p = num;
        while (p != -1) {
            if (lockStatus[p] != 0) return false;
            p = parent[p];
        }

        bool hasLockedDescendant = false;
        vector<int> toUnlock;
        vector<int> q;
        q.push_back(num);
        int head = 0;

        while (head < q.size()) {
            int curr = q[head++];
            for (int child : children[curr]) {
                if (lockStatus[child] != 0) {
                    hasLockedDescendant = true;
                    toUnlock.push_back(child);
                }
                q.push_back(child);
            }
        }

        if (!hasLockedDescendant) return false;

        for (int node : toUnlock) {
            lockStatus[node] = 0;
        }

        lockStatus[num] = user;
        return true;
    }
};