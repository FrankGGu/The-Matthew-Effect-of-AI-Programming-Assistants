func checkDynasty(year int) string {
    if year < 221 {
        return "先秦"
    } else if year < 581 {
        return "两汉"
    } else if year < 907 {
        return "魏晋南北朝"
    } else if year < 1279 {
        return "隋唐"
    } else if year < 1912 {
        return "宋元"
    } else {
        return "现代"
    }
}