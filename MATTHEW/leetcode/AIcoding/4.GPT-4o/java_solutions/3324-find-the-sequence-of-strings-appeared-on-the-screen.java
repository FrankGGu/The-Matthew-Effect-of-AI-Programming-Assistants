class Solution {
    public List<String> findSequences(String s) {
        List<String> result = new ArrayList<>();
        Set<String> seen = new HashSet<>();
        StringBuilder current = new StringBuilder();

        for (char c : s.toCharArray()) {
            current.append(c);
            if (!seen.contains(current.toString())) {
                seen.add(current.toString());
                result.add(current.toString());
            }
        }

        return result;
    }
}