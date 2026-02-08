class Solution {
    int[] parent;
    int count;

    public int numSimilarGroups(String[] strs) {
        int n = strs.length;
        parent = new int[n];
        count = n;

        for (int i = 0; i < n; i++) {
            parent[i] = i;
        }

        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                if (isSimilar(strs[i], strs[j])) {
                    union(i, j);
                }
            }
        }

        return count;
    }

    private boolean isSimilar(String s1, String s2) {
        int diffCount = 0;
        int[] diffIndices = new int[2];
        int k = 0;

        for (int i = 0; i < s1.length(); i++) {
            if (s1.charAt(i) != s2.charAt(i)) {
                diffCount++;
                if (k < 2) {
                    diffIndices[k++] = i;
                }
            }
        }

        if (diffCount == 0) {
            return true;
        }

        if (diffCount == 2) {
            return s1.charAt(diffIndices[0]) == s2.charAt(diffIndices[1]) &&
                   s1.charAt(diffIndices[1]) == s2.charAt(diffIndices[0]);
        }

        return false;
    }

    private int find(int i) {
        if (parent[i] == i) {
            return i;
        }
        return parent[i] = find(parent[i]);
    }

    private void union(int i, int j) {
        int rootI = find(i);
        int rootJ = find(j);

        if (rootI != rootJ) {
            parent[rootI] = rootJ;
            count--;
        }
    }
}