class Solution {
    public String maxValue(String n, String x) {
        StringBuilder sb = new StringBuilder();
        if (n.charAt(0) == '-') {
            sb.append('-');
            for (int i = 1; i < n.length(); i++) {
                if (x.charAt(0) < n.charAt(i)) {
                    sb.append(x);
                    sb.append(n.substring(i));
                    return sb.toString();
                }
                sb.append(n.charAt(i));
            }
            sb.append(x);
        } else {
            for (int i = 0; i < n.length(); i++) {
                if (x.charAt(0) > n.charAt(i)) {
                    sb.append(x);
                    sb.append(n.substring(i));
                    return sb.toString();
                }
                sb.append(n.charAt(i));
            }
            sb.append(x);
        }
        return sb.toString();
    }
}