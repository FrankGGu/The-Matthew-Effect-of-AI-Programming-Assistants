var countSegments = function(s) {
    if (!s) return 0;
    s = s.trim();
    if (!s) return 0;
    return s.split(/\s+/).length;
};