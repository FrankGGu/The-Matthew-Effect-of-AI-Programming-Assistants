class Solution {
    public int[] groupStrings(String[] words) {
        Map<Integer, Integer> maskToCount = new HashMap<>();
        for (String word : words) {
            int mask = 0;
            for (char c : word.toCharArray()) {
                mask |= (1 << (c - 'a'));
            }
            maskToCount.put(mask, maskToCount.getOrDefault(mask, 0) + 1);
        }

        int totalGroups = 0;
        int maxSize = 0;
        Set<Integer> visited = new HashSet<>();

        for (int mask : maskToCount.keySet()) {
            if (!visited.contains(mask)) {
                int currentSize = 0;
                Queue<Integer> queue = new LinkedList<>();
                queue.offer(mask);
                visited.add(mask);

                while (!queue.isEmpty()) {
                    int current = queue.poll();
                    currentSize += maskToCount.get(current);

                    for (int i = 0; i < 26; i++) {
                        int neighbor = current ^ (1 << i);
                        if (maskToCount.containsKey(neighbor) && !visited.contains(neighbor)) {
                            visited.add(neighbor);
                            queue.offer(neighbor);
                        }
                    }

                    for (int i = 0; i < 26; i++) {
                        if ((current & (1 << i)) != 0) {
                            for (int j = 0; j < 26; j++) {
                                if ((current & (1 << j)) == 0) {
                                    int neighbor = current ^ (1 << i) ^ (1 << j);
                                    if (maskToCount.containsKey(neighbor) && !visited.contains(neighbor)) {
                                        visited.add(neighbor);
                                        queue.offer(neighbor);
                                    }
                                }
                            }
                        }
                    }
                }

                totalGroups++;
                maxSize = Math.max(maxSize, currentSize);
            }
        }

        return new int[]{totalGroups, maxSize};
    }
}