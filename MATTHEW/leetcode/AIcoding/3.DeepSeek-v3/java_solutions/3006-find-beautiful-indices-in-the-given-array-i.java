class Solution {
    public List<Integer> beautifulIndices(String s, String a, String b, int k) {
        List<Integer> indicesA = new ArrayList<>();
        List<Integer> indicesB = new ArrayList<>();
        List<Integer> result = new ArrayList<>();

        int n = s.length();
        int lenA = a.length();
        int lenB = b.length();

        for (int i = 0; i <= n - lenA; i++) {
            if (s.substring(i, i + lenA).equals(a)) {
                indicesA.add(i);
            }
        }

        for (int i = 0; i <= n - lenB; i++) {
            if (s.substring(i, i + lenB).equals(b)) {
                indicesB.add(i);
            }
        }

        for (int i : indicesA) {
            int left = Math.max(0, i - k);
            int right = i + k;

            int low = 0;
            int high = indicesB.size() - 1;
            boolean found = false;

            while (low <= high) {
                int mid = low + (high - low) / 2;
                int j = indicesB.get(mid);
                if (j >= left && j <= right) {
                    found = true;
                    break;
                } else if (j < left) {
                    low = mid + 1;
                } else {
                    high = mid - 1;
                }
            }

            if (found) {
                result.add(i);
            }
        }

        return result;
    }
}