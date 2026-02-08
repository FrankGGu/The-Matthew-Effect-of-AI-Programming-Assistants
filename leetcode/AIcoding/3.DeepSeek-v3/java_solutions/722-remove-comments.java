class Solution {
    public List<String> removeComments(String[] source) {
        List<String> res = new ArrayList<>();
        boolean inBlock = false;
        StringBuilder sb = new StringBuilder();

        for (String line : source) {
            int i = 0;
            int n = line.length();
            if (!inBlock) {
                sb = new StringBuilder();
            }
            while (i < n) {
                if (!inBlock && i + 1 < n && line.charAt(i) == '/' && line.charAt(i + 1) == '*') {
                    inBlock = true;
                    i += 2;
                } else if (inBlock && i + 1 < n && line.charAt(i) == '*' && line.charAt(i + 1) == '/') {
                    inBlock = false;
                    i += 2;
                } else if (!inBlock && i + 1 < n && line.charAt(i) == '/' && line.charAt(i + 1) == '/') {
                    break;
                } else if (!inBlock) {
                    sb.append(line.charAt(i));
                    i++;
                } else {
                    i++;
                }
            }
            if (!inBlock && sb.length() > 0) {
                res.add(sb.toString());
            }
        }
        return res;
    }
}