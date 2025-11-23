class LockingTree {
    private int[] parent;
    private int[] lockedBy;
    private Map<Integer, List<Integer>> children;

    public LockingTree(int[] parent) {
        this.parent = parent;
        this.lockedBy = new int[parent.length];
        Arrays.fill(lockedBy, -1);
        this.children = new HashMap<>();
        for (int i = 0; i < parent.length; i++) {
            children.putIfAbsent(parent[i], new ArrayList<>());
            children.get(parent[i]).add(i);
        }
    }

    public boolean lock(int num, int user) {
        if (lockedBy[num] == -1) {
            lockedBy[num] = user;
            return true;
        }
        return false;
    }

    public boolean unlock(int num, int user) {
        if (lockedBy[num] == user) {
            lockedBy[num] = -1;
            return true;
        }
        return false;
    }

    public boolean upgrade(int num, int user) {
        if (lockedBy[num] != -1) {
            return false;
        }
        if (!hasLockedAncestor(num)) {
            if (hasLockedDescendant(num)) {
                unlockDescendants(num);
                lockedBy[num] = user;
                return true;
            }
        }
        return false;
    }

    private boolean hasLockedAncestor(int num) {
        int p = parent[num];
        while (p != -1) {
            if (lockedBy[p] != -1) {
                return true;
            }
            p = parent[p];
        }
        return false;
    }

    private boolean hasLockedDescendant(int num) {
        Queue<Integer> queue = new LinkedList<>();
        queue.offer(num);
        while (!queue.isEmpty()) {
            int node = queue.poll();
            if (children.containsKey(node)) {
                for (int child : children.get(node)) {
                    if (lockedBy[child] != -1) {
                        return true;
                    }
                    queue.offer(child);
                }
            }
        }
        return false;
    }

    private void unlockDescendants(int num) {
        Queue<Integer> queue = new LinkedList<>();
        queue.offer(num);
        while (!queue.isEmpty()) {
            int node = queue.poll();
            if (children.containsKey(node)) {
                for (int child : children.get(node)) {
                    lockedBy[child] = -1;
                    queue.offer(child);
                }
            }
        }
    }
}