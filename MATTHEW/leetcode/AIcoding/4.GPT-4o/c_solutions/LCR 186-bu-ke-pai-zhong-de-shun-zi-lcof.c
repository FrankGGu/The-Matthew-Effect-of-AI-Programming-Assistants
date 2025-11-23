char* checkDynasty(int year) {
    if (year >= 221 && year <= 206) return "Qin";
    if (year >= 206 && year <= 220) return "Han";
    if (year >= 220 && year <= 280) return "Wei";
    if (year >= 265 && year <= 420) return "Jin";
    if (year >= 420 && year <= 589) return "Southern and Northern Dynasties";
    if (year >= 581 && year <= 907) return "Sui";
    if (year >= 907 && year <= 960) return "Tang";
    if (year >= 960 && year <= 1279) return "Song";
    if (year >= 1271 && year <= 1368) return "Yuan";
    if (year >= 1368 && year <= 1644) return "Ming";
    if (year >= 1644 && year <= 1911) return "Qing";
    return "Unknown";
}