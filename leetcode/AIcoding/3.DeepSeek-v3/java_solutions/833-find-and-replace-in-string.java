class Solution {
    public String findReplaceString(String s, int[] indices, String[] sources, String[] targets) {
        StringBuilder sb = new StringBuilder();
        int n = s.length();
        int[] match = new int[n];
        Arrays.fill(match, -1);

        for (int i = 0; i < indices.length; i++) {
            int index = indices[i];
            String source = sources[i];
            if (s.startsWith(source, index)) {
                match[index] = i;
            }
        }

        int i = 0;
        while (i < n) {
            if (match[i] != -1) {
                int idx = match[i];
                sb.append(targets[idx]);
                i += sources[idx].length();
            } else {
                sb.append(s.charAt(i));
                i++;
            }
        }

        return sb.toString();
    }
}