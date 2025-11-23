public class Solution {

import java.util.*;

public class Solution {
    public int createSortedArray(List<Integer> instructions) {
        int n = instructions.size();
        int[] result = new int[1];
        int[] tree = new int[100001];

        class FenwickTree {
            int size;
            int[] tree;

            FenwickTree(int size) {
                this.size = size;
                tree = new int[size + 1];
            }

            void update(int index, int delta) {
                index++;
                while (index <= size) {
                    tree[index] += delta;
                    index += index & -index;
                }
            }

            int query(int index) {
                index++;
                int sum = 0;
                while (index > 0) {
                    sum += tree[index];
                    index -= index & -index;
                }
                return sum;
            }
        }

        FenwickTree ft = new FenwickTree(100000);

        for (int i = 0; i < n; i++) {
            int num = instructions.get(i);
            int less = ft.query(num - 1);
            int greater = ft.query(100000) - ft.query(num);
            result[0] += Math.min(less, greater);
            ft.update(num, 1);
        }

        return result[0];
    }
}
}