class Solution {
    public double[] convertTemperature(double celsius) {
        double[] result = new double[2];
        result[0] = celsius + 273.15; // Kelvin
        result[1] = celsius * 1.80 + 32.00; // Fahrenheit
        return result;
    }
}