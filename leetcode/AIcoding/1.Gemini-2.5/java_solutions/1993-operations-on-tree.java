import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;

class TreeLock {

    private int n;
    private int[] parent;
    private List<List<Integer>> children;
    private int[] lockedBy; // Stores user ID if locked, -1 if unlocked
    private int[] lockedDescendantCount; // Stores count of locked nodes in the subtree rooted at this node (excluding itself)

    public TreeLock(int[] parent) {
        this.n = parent.length;
        this.parent = parent;

        children = new ArrayList[n];
        for (int i = 0; i < n; i++) {
            children[i] = new ArrayList<>();
        }
        for (int i = 1; i < n; i++) {
            children[parent[i]].add(i);
        }

        lockedBy = new int[n];
        Arrays.fill(lockedBy, -1); // -1 means unlocked

        lockedDescendantCount = new int[n];
        Arrays.fill(lockedDescendantCount, 0);
    }

    public boolean lock(int num, int user) {
        // Condition 1: Node num must be unlocked.
        if (lockedBy[num] != -1) {
            return false;
        }

        // Condition 2: No ancestor of num can be locked.
        int p = parent[num];
        while (p != -1) {
            if (lockedBy[p] != -1) {
                return false;
            }
            p = parent[p];
        }

        // Condition 3: No descendant of num can be locked.
        if (lockedDescendantCount[num] > 0) {
            return false;
        }

        // All conditions met, lock the node
        lockedBy[num] = user;

        // Update lockedDescendantCount for all ancestors
        p = parent[num];
        while (p != -1) {
            lockedDescendantCount[p]++;
            p = parent[p];
        }

        return true;
    }

    public boolean unlock(int num, int user) {
        // Condition 1: Node num must be locked.
        // Condition 2: Node num must be locked by user.
        if (lockedBy[num] != user) {
            return false;
        }

        // All conditions met, unlock the node
        lockedBy[num] = -1;

        // Update lockedDescendantCount for all ancestors
        int p = parent[num];
        while (p != -1) {
            lockedDescendantCount[p]--;
            p = parent[p];
        }

        return true;
    }

    public boolean upgrade(int num, int user) {
        // Condition 1: Node num must be unlocked.
        if (lockedBy[num] != -1) {
            return false;
        }

        // Condition 2: No ancestor of num can be locked.
        int p = parent[num];
        while (p != -1) {
            if (lockedBy[p] != -1) {
                return false;
            }
            p = parent[p];
        }

        // Condition 3: At least one descendant of num must be locked.
        if (lockedDescendantCount[num] == 0) {
            return false;
        }

        // All conditions met, perform upgrade
        // Store the current count of locked descendants for num
        int numLockedDescendantsBeforeUpgrade = lockedDescendantCount[num];

        // Condition 4: All locked descendants of num must be unlocked.
        // Perform a BFS to find and unlock all locked descendants.
        Queue<Integer> queue = new LinkedList<>();
        queue.offer(num);

        while (!queue.isEmpty()) {
            int curr = queue.poll();
            for (int child : children[curr]) {
                if (lockedBy[child] != -1) {
                    lockedBy[child] = -1; // Unlock this descendant
                }
                queue.offer(child);
            }
        }

        // Lock node num itself
        lockedBy[num] = user;

        // Update lockedDescendantCount for ancestors of num
        // Net change for each ancestor: - (numLockedDescendantsBeforeUpgrade) + 1 (for num itself)
        p = parent[num];
        while (p != -1) {
            lockedDescendantCount[p] = lockedDescendantCount[p] - numLockedDescendantsBeforeUpgrade + 1;
            p = parent[p];
        }

        return true;
    }
}