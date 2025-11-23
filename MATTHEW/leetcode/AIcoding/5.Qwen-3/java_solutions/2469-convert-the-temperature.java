public class Solution {

import java.util.*;

public class Solution {
    public List<Double> convertTemperature(double celsius) {
        double kelvin = celsius + 273.15;
        double fahrenheit = celsius * 9.0 / 5.0 + 32.0;
        return Arrays.asList(kelvin, fahrenheit);
    }
}
}