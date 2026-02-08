class Solution {
    public int kSimilarity(String s1, String s2) {
        Queue<String> queue = new LinkedList<>();
        Set<String> visited = new HashSet<>();
        queue.offer(s1);
        visited.add(s1);
        int level = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                String current = queue.poll();
                if (current.equals(s2)) {
                    return level;
                }
                for (String neighbor : getNeighbors(current, s2)) {
                    if (!visited.contains(neighbor)) {
                        visited.add(neighbor);
                        queue.offer(neighbor);
                    }
                }
            }
            level++;
        }
        return -1;
    }

    private List<String> getNeighbors(String current, String target) {
        List<String> neighbors = new ArrayList<>();
        int i = 0;
        while (i < current.length() && current.charAt(i) == target.charAt(i)) {
            i++;
        }
        for (int j = i + 1; j < current.length(); j++) {
            if (current.charAt(j) == target.charAt(i)) {
                char[] chars = current.toCharArray();
                char temp = chars[i];
                chars[i] = chars[j];
                chars[j] = temp;
                neighbors.add(new String(chars));
            }
        }
        return neighbors;
    }
}