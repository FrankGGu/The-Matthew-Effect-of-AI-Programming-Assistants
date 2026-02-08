#include <vector>
#include <queue>

class TreeLock {
private:
    int n;
    std::vector<int> parent_arr;
    std::vector<std::vector<int>> children_adj;
    std::vector<int> locked_by; // 0 if unlocked, user_id if locked

    bool hasLockedAncestor(int num) {
        int curr = parent_arr[num];
        while (curr != -1) {
            if (locked_by[curr] != 0) {
                return true;
            }
            curr = parent_arr[curr];
        }
        return false;
    }

    bool hasLockedDescendant(int num) {
        std::queue<int> q;
        for (int child : children_adj[num]) {
            q.push(child);
        }

        while (!q.empty()) {
            int curr = q.front();
            q.pop();

            if (locked_by[curr] != 0) {
                return true;
            }

            for (int child : children_adj[curr]) {
                q.push(child);
            }
        }
        return false;
    }

    void unlockDescendants(int num) {
        std::queue<int> q;
        for (int child : children_adj[num]) {
            q.push(child);
        }

        while (!q.empty()) {
            int curr = q.front();
            q.pop();

            locked_by[curr] = 0;

            for (int child : children_adj[curr]) {
                q.push(child);
            }
        }
    }

public:
    TreeLock(std::vector<int>& parent) {
        n = parent.size();
        parent_arr = parent;
        children_adj.resize(n);
        locked_by.assign(n, 0);

        for (int i = 1; i < n; ++i) {
            children_adj[parent[i]].push_back(i);
        }
    }

    bool lock(int num, int user) {
        if (locked_by[num] == 0) {
            locked_by[num] = user;
            return true;
        }
        return false;
    }

    bool unlock(int num, int user) {
        if (locked_by[num] == user) {
            locked_by[num] = 0;
            return true;
        }
        return false;
    }

    bool upgrade(int num, int user) {
        if (locked_by[num] != 0) {
            return false;
        }

        if (hasLockedAncestor(num)) {
            return false;
        }

        if (!hasLockedDescendant(num)) {
            return false;
        }

        locked_by[num] = user;
        unlockDescendants(num);

        return true;
    }
};