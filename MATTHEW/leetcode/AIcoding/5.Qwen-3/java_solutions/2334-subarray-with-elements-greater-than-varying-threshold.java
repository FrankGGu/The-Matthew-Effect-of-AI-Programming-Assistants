public class Solution {

import java.util.*;

public class Solution {
    public int[] validSubarraySize(int[] nums, int[] threshold) {
        int n = nums.length;
        int[] result = new int[1];
        result[0] = -1;

        int[] index = new int[n];
        for (int i = 0; i < n; i++) {
            index[i] = i;
        }

        Arrays.sort(index, (i, j) -> nums[i] - nums[j]);

        UnionFind uf = new UnionFind(n);
        for (int i = 0; i < n; i++) {
            int idx = index[i];
            int left = idx - 1;
            int right = idx + 1;
            if (left >= 0 && nums[left] > nums[idx]) {
                uf.union(idx, left);
            }
            if (right < n && nums[right] > nums[idx]) {
                uf.union(idx, right);
            }
            int size = uf.size[idx];
            if (size >= threshold[idx]) {
                result[0] = size;
                return result;
            }
        }

        return result;
    }

    private class UnionFind {
        int[] parent;
        int[] size;

        public UnionFind(int n) {
            parent = new int[n];
            size = new int[n];
            for (int i = 0; i < n; i++) {
                parent[i] = i;
                size[i] = 1;
            }
        }

        public int find(int x) {
            while (parent[x] != x) {
                parent[x] = parent[parent[x]];
                x = parent[x];
            }
            return x;
        }

        public void union(int x, int y) {
            int rootX = find(x);
            int rootY = find(y);
            if (rootX == rootY) return;
            if (size[rootX] < size[rootY]) {
                int temp = rootX;
                rootX = rootY;
                rootY = temp;
            }
            parent[rootY] = rootX;
            size[rootX] += size[rootY];
        }
    }
}
}