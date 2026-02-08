class LockingTree {
public:
    LockingTree(vector<int>& parent) {
        int n = parent.size();
        this->parent = parent;
        children.resize(n);
        for (int i = 1; i < n; ++i) {
            children[parent[i]].push_back(i);
        }
        locked.resize(n, -1);
    }

    bool lock(int num, int user) {
        if (locked[num] != -1) {
            return false;
        }
        locked[num] = user;
        return true;
    }

    bool unlock(int num, int user) {
        if (locked[num] != user) {
            return false;
        }
        locked[num] = -1;
        return true;
    }

    bool upgrade(int num, int user) {
        if (locked[num] != -1) {
            return false;
        }
        if (!hasLockedDescendant(num)) {
            return false;
        }
        if (hasLockedAncestor(num)) {
            return false;
        }
        unlockAllDescendants(num);
        locked[num] = user;
        return true;
    }

private:
    vector<int> parent;
    vector<vector<int>> children;
    vector<int> locked;

    bool hasLockedDescendant(int num) {
        for (int child : children[num]) {
            if (locked[child] != -1 || hasLockedDescendant(child)) {
                return true;
            }
        }
        return false;
    }

    bool hasLockedAncestor(int num) {
        while (num != -1) {
            num = parent[num];
            if (num != -1 && locked[num] != -1) {
                return true;
            }
        }
        return false;
    }

    void unlockAllDescendants(int num) {
        for (int child : children[num]) {
            locked[child] = -1;
            unlockAllDescendants(child);
        }
    }
};