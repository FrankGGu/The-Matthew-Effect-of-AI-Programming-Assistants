function checkDynasty(year) {
    if (year >= 2023) return "现代";
    if (year >= 1949) return "中华人民共和国";
    if (year >= 1912) return "中华民国";
    if (year >= 1911) return "清朝";
    if (year >= 1840) return "鸦片战争";
    if (year >= 1368) return "明朝";
    if (year >= 1271) return "元朝";
    if (year >= 618) return "唐朝";
    if (year >= 220) return "三国";
    if (year >= 221) return "汉朝";
    if (year >= 221) return "秦朝";
    return "夏朝";
}