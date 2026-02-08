class Solution {
    public String checkDynasty(int year) {
        if (year >= 2021) return "现代";
        if (year >= 1912) return "民国";
        if (year >= 1840) return "清朝";
        if (year >= 1368) return "明朝";
        if (year >= 1271) return "元朝";
        if (year >= 618) return "唐朝";
        if (year >= 220) return "魏晋南北朝";
        if (year >= 221) return "三国";
        if (year >= 206) return "汉朝";
        if (year >= 476) return "春秋战国";
        return "先秦";
    }
}