class Solution {
    public String entityParser(String text) {
        StringBuilder sb = new StringBuilder();
        int i = 0;
        int n = text.length();
        while (i < n) {
            if (text.charAt(i) == '&') {
                if (i + 3 < n && text.substring(i, i + 4).equals("&gt;")) {
                    sb.append('>');
                    i += 4;
                } else if (i + 3 < n && text.substring(i, i + 4).equals("&lt;")) {
                    sb.append('<');
                    i += 4;
                } else if (i + 4 < n && text.substring(i, i + 5).equals("&amp;")) {
                    sb.append('&');
                    i += 5;
                } else if (i + 5 < n && text.substring(i, i + 6).equals("&quot;")) {
                    sb.append('"');
                    i += 6;
                } else if (i + 5 < n && text.substring(i, i + 6).equals("&apos;")) {
                    sb.append('\'');
                    i += 6;
                } else if (i + 6 < n && text.substring(i, i + 7).equals("&frasl;")) {
                    sb.append('/');
                    i += 7;
                } else {
                    sb.append(text.charAt(i));
                    i++;
                }
            } else {
                sb.append(text.charAt(i));
                i++;
            }
        }
        return sb.toString();
    }
}