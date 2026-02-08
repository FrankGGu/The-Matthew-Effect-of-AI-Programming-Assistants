class Solution {
    public String minimizeStringValue(String s) {
        int[] freq = new int[26];
        char[] arr = s.toCharArray();
        for (char c : arr) {
            if (c != '?') {
                freq[c - 'a']++;
            }
        }

        PriorityQueue<Character> pq = new PriorityQueue<>((a, b) -> {
            if (freq[a - 'a'] != freq[b - 'a']) {
                return freq[a - 'a'] - freq[b - 'a'];
            } else {
                return a - b;
            }
        });

        for (char c = 'a'; c <= 'z'; c++) {
            pq.offer(c);
        }

        List<Character> list = new ArrayList<>();
        for (char c : arr) {
            if (c == '?') {
                char minChar = pq.poll();
                list.add(minChar);
                freq[minChar - 'a']++;
                pq.offer(minChar);
            }
        }

        Collections.sort(list);
        int idx = 0;
        StringBuilder sb = new StringBuilder();
        for (char c : arr) {
            if (c == '?') {
                sb.append(list.get(idx++));
            } else {
                sb.append(c);
            }
        }

        return sb.toString();
    }
}