class Solution {
    public List<String> findHighAccessEmployees(List<List<String>> access_times) {
        Map<String, List<Integer>> map = new HashMap<>();
        for (List<String> entry : access_times) {
            String name = entry.get(0);
            String time = entry.get(1);
            int minutes = Integer.parseInt(time.substring(0, 2)) * 60 + Integer.parseInt(time.substring(2));
            map.computeIfAbsent(name, k -> new ArrayList<>()).add(minutes);
        }

        List<String> result = new ArrayList<>();
        for (Map.Entry<String, List<Integer>> entry : map.entrySet()) {
            String name = entry.getKey();
            List<Integer> times = entry.getValue();
            if (times.size() < 3) continue;
            Collections.sort(times);
            for (int i = 0; i <= times.size() - 3; i++) {
                if (times.get(i + 2) - times.get(i) < 60) {
                    result.add(name);
                    break;
                }
            }
        }
        return result;
    }
}