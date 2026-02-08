class Solution {
    public int minMutation(String start, String end, String[] bank) {
        Set<String> bankSet = new HashSet<>(Arrays.asList(bank));
        if (!bankSet.contains(end)) {
            return -1;
        }
        char[] chars = {'A', 'C', 'G', 'T'};
        Queue<String> queue = new LinkedList<>();
        Set<String> visited = new HashSet<>();
        queue.offer(start);
        visited.add(start);
        int level = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                String current = queue.poll();
                if (current.equals(end)) {
                    return level;
                }
                char[] currentArray = current.toCharArray();
                for (int j = 0; j < currentArray.length; j++) {
                    char originalChar = currentArray[j];
                    for (char c : chars) {
                        if (c == originalChar) {
                            continue;
                        }
                        currentArray[j] = c;
                        String next = new String(currentArray);
                        if (bankSet.contains(next) && !visited.contains(next)) {
                            queue.offer(next);
                            visited.add(next);
                        }
                    }
                    currentArray[j] = originalChar;
                }
            }
            level++;
        }
        return -1;
    }
}