class Solution {
public:
    double convert(double x, string fromUnit, string toUnit) {
        unordered_map<string, double> conversionFactors = {
            {"m", 1.0}, {"km", 1000.0}, {"cm", 0.01}, {"mm", 0.001}, 
            {"mi", 1609.34}, {"yd", 0.9144}, {"ft", 0.3048}, {"in", 0.0254}
        };

        return x * conversionFactors[fromUnit] / conversionFactors[toUnit];
    }
};