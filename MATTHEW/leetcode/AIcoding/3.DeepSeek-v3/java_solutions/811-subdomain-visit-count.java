class Solution {
    public List<String> subdomainVisits(String[] cpdomains) {
        Map<String, Integer> counts = new HashMap<>();
        for (String domain : cpdomains) {
            String[] parts = domain.split(" ");
            int count = Integer.parseInt(parts[0]);
            String[] frags = parts[1].split("\\.");
            String current = "";
            for (int i = frags.length - 1; i >= 0; --i) {
                current = frags[i] + (i < frags.length - 1 ? "." : "") + current;
                counts.put(current, counts.getOrDefault(current, 0) + count);
            }
        }
        List<String> result = new ArrayList<>();
        for (Map.Entry<String, Integer> entry : counts.entrySet()) {
            result.add(entry.getValue() + " " + entry.getKey());
        }
        return result;
    }
}