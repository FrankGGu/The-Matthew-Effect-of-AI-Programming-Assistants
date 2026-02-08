class Solution {
    public List<String> addOperators(String num, int target) {
        List<String> result = new ArrayList<>();
        if (num == null || num.length() == 0) return result;
        backtrack(result, num, target, "", 0, 0, 0);
        return result;
    }

    private void backtrack(List<String> result, String num, int target, String path, int pos, long eval, long multed) {
        if (pos == num.length()) {
            if (eval == target) {
                result.add(path);
            }
            return;
        }
        for (int i = pos; i < num.length(); i++) {
            if (i != pos && num.charAt(pos) == '0') break;
            long cur = Long.parseLong(num.substring(pos, i + 1));
            if (pos == 0) {
                backtrack(result, num, target, path + cur, i + 1, cur, cur);
            } else {
                backtrack(result, num, target, path + "+" + cur, i + 1, eval + cur, cur);
                backtrack(result, num, target, path + "-" + cur, i + 1, eval - cur, -cur);
                backtrack(result, num, target, path + "*" + cur, i + 1, eval - multed + multed * cur, multed * cur);
            }
        }
    }
}