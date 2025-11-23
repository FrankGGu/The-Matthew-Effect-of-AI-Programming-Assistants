class Solution {
    public List<String> restoreIpAddresses(String s) {
        List<String> res = new ArrayList<>();
        backtrack(s, 0, new ArrayList<>(), res);
        return res;
    }

    private void backtrack(String s, int start, List<String> path, List<String> res) {
        if (path.size() == 4) {
            if (start == s.length()) {
                res.add(String.join(".", path));
            }
            return;
        }

        for (int i = 1; i <= 3; i++) {
            if (start + i > s.length()) break;
            String segment = s.substring(start, start + i);
            if (isValid(segment)) {
                path.add(segment);
                backtrack(s, start + i, path, res);
                path.remove(path.size() - 1);
            }
        }
    }

    private boolean isValid(String segment) {
        if (segment.length() > 1 && segment.charAt(0) == '0') return false;
        int num = Integer.parseInt(segment);
        return num >= 0 && num <= 255;
    }
}