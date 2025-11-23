function guessYear(year) {
    if (year < 0) return "前";
    if (year <= 220) return "汉";
    if (year <= 589) return "晋";
    if (year <= 907) return "唐";
    if (year <= 1368) return "宋";
    if (year <= 1644) return "明";
    return "清";
}