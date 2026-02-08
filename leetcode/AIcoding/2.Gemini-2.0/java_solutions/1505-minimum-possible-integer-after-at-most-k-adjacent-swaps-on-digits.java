import java.util.ArrayList;
import java.util.List;

class Solution {
    public String minInteger(String num, int k) {
        int n = num.length();
        List<List<Integer>> pos = new ArrayList<>();
        for (int i = 0; i < 10; i++) {
            pos.add(new ArrayList<>());
        }
        for (int i = 0; i < n; i++) {
            pos.get(num.charAt(i) - '0').add(i);
        }

        BIT bit = new BIT(n);
        StringBuilder res = new StringBuilder();
        for (int i = 0; i < n; i++) {
            for (int digit = 0; digit < 10; digit++) {
                if (pos.get(digit).size() > 0) {
                    int index = pos.get(digit).get(0);
                    int actualIndex = index + bit.query(index);
                    if (actualIndex <= k) {
                        k -= actualIndex;
                        res.append(digit);
                        pos.get(digit).remove(0);
                        bit.update(index, 1);
                        break;
                    }
                }
            }
        }

        return res.toString();
    }

    static class BIT {
        int[] tree;
        int n;

        public BIT(int n) {
            this.n = n;
            tree = new int[n + 1];
        }

        public void update(int i, int val) {
            i++;
            while (i <= n) {
                tree[i] += val;
                i += i & -i;
            }
        }

        public int query(int i) {
            i++;
            int sum = 0;
            while (i > 0) {
                sum += tree[i];
                i -= i & -i;
            }
            return sum;
        }
    }
}