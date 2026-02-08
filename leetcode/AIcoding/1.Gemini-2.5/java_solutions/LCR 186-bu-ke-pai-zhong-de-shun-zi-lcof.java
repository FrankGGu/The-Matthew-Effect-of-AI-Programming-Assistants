import java.util.Map;
import java.util.TreeMap;

class Solution {
    private static final TreeMap<Integer, String> DYNASTIES_BY_START_YEAR;
    private static final TreeMap<Integer, Integer> DYNASTY_END_YEARS;

    static {
        DYNASTIES_BY_START_YEAR = new TreeMap<>();
        DYNASTY_END_YEARS = new TreeMap<>();

        DYNASTIES_BY_START_YEAR.put(-2070, "Xia Dynasty");
        DYNASTY_END_YEARS.put(-2070, -1600);
        DYNASTIES_BY_START_YEAR.put(-1600, "Shang Dynasty");
        DYNASTY_END_YEARS.put(-1600, -1046);
        DYNASTIES_BY_START_YEAR.put(-1046, "Zhou Dynasty");
        DYNASTY_END_YEARS.put(-1046, -256);
        DYNASTIES_BY_START_YEAR.put(-221, "Qin Dynasty");
        DYNASTY_END_YEARS.put(-221, -206);
        DYNASTIES_BY_START_YEAR.put(-206, "Western Han Dynasty");
        DYNASTY_END_YEARS.put(-206, 9);
        DYNASTIES_BY_START_YEAR.put(9, "Xin Dynasty");
        DYNASTY_END_YEARS.put(9, 23);
        DYNASTIES_BY_START_YEAR.put(25, "Eastern Han Dynasty");
        DYNASTY_END_YEARS.put(25, 220);
        DYNASTIES_BY_START_YEAR.put(220, "Three Kingdoms Period");
        DYNASTY_END_YEARS.put(220, 280);
        DYNASTIES_BY_START_YEAR.put(265, "Western Jin Dynasty");
        DYNASTY_END_YEARS.put(265, 316);
        DYNASTIES_BY_START_YEAR.put(317, "Eastern Jin Dynasty");
        DYNASTY_END_YEARS.put(317, 420);
        DYNASTIES_BY_START_YEAR.put(420, "Southern and Northern Dynasties");
        DYNASTY_END_YEARS.put(420, 589);
        DYNASTIES_BY_START_YEAR.put(581, "Sui Dynasty");
        DYNASTY_END_YEARS.put(581, 618);
        DYNASTIES_BY_START_YEAR.put(618, "Tang Dynasty");
        DYNASTY_END_YEARS.put(618, 907);
        DYNASTIES_BY_START_YEAR.put(907, "Five Dynasties and Ten Kingdoms");
        DYNASTY_END_YEARS.put(907, 960);
        DYNASTIES_BY_START_YEAR.put(960, "Northern Song Dynasty");
        DYNASTY_END_YEARS.put(960, 1127);
        DYNASTIES_BY_START_YEAR.put(1127, "Southern Song Dynasty");
        DYNASTY_END_YEARS.put(1127, 1279);
        DYNASTIES_BY_START_YEAR.put(1271, "Yuan Dynasty");
        DYNASTY_END_YEARS.put(1271, 1368);
        DYNASTIES_BY_START_YEAR.put(1368, "Ming Dynasty");
        DYNASTY_END_YEARS.put(1368, 1644);
        DYNASTIES_BY_START_YEAR.put(1644, "Qing Dynasty");
        DYNASTY_END_YEARS.put(1644, 1912);
        DYNASTIES_BY_START_YEAR.put(1912, "Republic of China");
        DYNASTY_END_YEARS.put(1912, 1949);
        DYNASTIES_BY_START_YEAR.put(1949, "People's Republic of China");
        DYNASTY_END_YEARS.put(1949, Integer.MAX_VALUE);
    }

    public String getDynasty(int year) {
        Map.Entry<Integer, String> entry = DYNASTIES_BY_START_YEAR.floorEntry(year);

        if (entry == null) {
            return "Unknown (Before recorded history)";
        }

        int startYear = entry.getKey();
        String dynastyName = entry.getValue();
        int endYear = DYNASTY_END_YEARS.get(startYear);

        if (year >= startYear && year <= endYear) {
            return dynastyName;
        } else {
            return "Interregnum or Transition Period";
        }
    }
}