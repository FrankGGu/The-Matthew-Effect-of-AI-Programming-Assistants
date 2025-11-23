class Solution {
    public String[] shortestSubstrings(String[] arr) {
        int n = arr.length;
        String[] result = new String[n];
        for (int i = 0; i < n; i++) {
            String s = arr[i];
            String shortest = "";
            for (int len = 1; len <= s.length(); len++) {
                boolean found = false;
                for (int j = 0; j <= s.length() - len; j++) {
                    String sub = s.substring(j, j + len);
                    boolean isUnique = true;
                    for (int k = 0; k < n; k++) {
                        if (k != i && arr[k].contains(sub)) {
                            isUnique = false;
                            break;
                        }
                    }
                    if (isUnique) {
                        if (shortest.isEmpty() || sub.compareTo(shortest) < 0) {
                            shortest = sub;
                        }
                        found = true;
                    }
                }
                if (found) {
                    break;
                }
            }
            result[i] = shortest;
        }
        return result;
    }
}