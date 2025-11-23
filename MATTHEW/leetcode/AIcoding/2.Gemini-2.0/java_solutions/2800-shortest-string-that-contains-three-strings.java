class Solution {
    public String shortestSuperstring(String a, String b, String c) {
        String[] arr = {a, b, c};
        String ans = null;
        int[] p = {0, 1, 2};
        do {
            String s = merge(merge(arr[p[0]], arr[p[1]]), arr[p[2]]);
            if (ans == null || s.length() < ans.length()) {
                ans = s;
            }
        } while (nextPermutation(p));
        return ans;
    }

    private boolean nextPermutation(int[] p) {
        int i = p.length - 2;
        while (i >= 0 && p[i] > p[i + 1]) {
            i--;
        }
        if (i < 0) {
            return false;
        }
        int j = p.length - 1;
        while (p[j] <= p[i]) {
            j--;
        }
        swap(p, i, j);
        reverse(p, i + 1, p.length - 1);
        return true;
    }

    private void swap(int[] p, int i, int j) {
        int temp = p[i];
        p[i] = p[j];
        p[j] = temp;
    }

    private void reverse(int[] p, int i, int j) {
        while (i < j) {
            swap(p, i++, j--);
        }
    }

    private String merge(String a, String b) {
        if (a.contains(b)) {
            return a;
        }
        if (b.contains(a)) {
            return b;
        }
        for (int i = Math.min(a.length(), b.length()); i >= 1; i--) {
            if (a.substring(a.length() - i).equals(b.substring(0, i))) {
                return a + b.substring(i);
            }
        }
        return a + b;
    }
}