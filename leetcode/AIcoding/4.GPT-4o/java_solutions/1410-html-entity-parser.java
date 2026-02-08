class Solution {
    public String entityParser(String text) {
        return text.replace("&gt;", ">")
                   .replace("&lt;", "<")
                   .replace("&amp;", "&")
                   .replace("&quot;", "\"")
                   .replace("&apos;", "'");
    }
}