public class Solution {

import java.util.*;

public class Solution {
    public int[] convertUnits(int[] units, String unitType) {
        Map<String, Integer> unitMap = new HashMap<>();
        unitMap.put("m", 1);
        unitMap.put("cm", 100);
        unitMap.put("mm", 1000);
        unitMap.put("km", 0.001);
        unitMap.put("inch", 39.3701);
        unitMap.put("foot", 3.28084);
        unitMap.put("yard", 1.09361);
        unitMap.put("mile", 0.000621371);

        int[] result = new int[units.length];
        double factor = unitMap.get(unitType);

        for (int i = 0; i < units.length; i++) {
            result[i] = (int) Math.round(units[i] * factor);
        }

        return result;
    }
}
}