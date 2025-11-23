import java.util.*;

class LockingTree {
    private int[] parent;
    private int[] lock;
    private List<List<Integer>> children;

    public LockingTree(int[] parent) {
        this.parent = parent;
        int n = parent.length;
        this.lock = new int[n];
        this.children = new ArrayList<>(n);
        for (int i = 0; i < n; i++) {
            children.add(new ArrayList<>());
        }
        for (int i = 0; i < n; i++) {
            if (parent[i] != -1) {
                children.get(parent[i]).add(i);
            }
        }
    }

    public boolean lock(int num, int user) {
        if (lock[num] == 0) {
            lock[num] = user;
            return true;
        }
        return false;
    }

    public boolean unlock(int num, int user) {
        if (lock[num] == user) {
            lock[num] = 0;
            return true;
        }
        return false;
    }

    public boolean upgrade(int num, int user) {
        if (lock[num] != 0) {
            return false;
        }
        int ancestor = parent[num];
        while (ancestor != -1) {
            if (lock[ancestor] != 0) {
                return false;
            }
            ancestor = parent[ancestor];
        }
        boolean hasLockedDescendant = hasLockedDescendant(num);
        if (!hasLockedDescendant) {
            return false;
        }
        unlockDescendants(num);
        lock[num] = user;
        return true;
    }

    private boolean hasLockedDescendant(int node) {
        if (lock[node] != 0) {
            return true;
        }
        for (int child : children.get(node)) {
            if (hasLockedDescendant(child)) {
                return true;
            }
        }
        return false;
    }

    private void unlockDescendants(int node) {
        if (lock[node] != 0) {
            lock[node] = 0;
        }
        for (int child : children.get(node)) {
            unlockDescendants(child);
        }
    }
}