class Solution {
    public String findReplaceString(String S, int[] indexes, String[] sources, String[] targets) {
        StringBuilder result = new StringBuilder(S);
        boolean[] replaced = new boolean[S.length()];

        for (int i = 0; i < indexes.length; i++) {
            int index = indexes[i];
            String source = sources[i];
            String target = targets[i];
            if (S.startsWith(source, index) && !replaced[index]) {
                result.replace(index, index + source.length(), target);
                for (int j = 0; j < source.length(); j++) {
                    replaced[index + j] = true;
                }
            }
        }

        return result.toString();
    }
}