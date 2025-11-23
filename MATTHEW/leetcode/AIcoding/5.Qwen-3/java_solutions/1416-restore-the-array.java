public class Solution {
    public int numberToWords(int num) {
        if (num == 0) return 0;
        String[] units = {"", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine"};
        String[] teens = {"Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen"};
        String[] tens = {"", "Ten", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"};
        String[] scales = {"", "Thousand", "Million", "Billion"};

        StringBuilder result = new StringBuilder();
        int scaleIndex = 0;

        while (num > 0) {
            int chunk = num % 1000;
            if (chunk > 0) {
                String chunkStr = convertChunk(chunk, units, teens, tens);
                if (scaleIndex > 0) {
                    result.insert(0, scales[scaleIndex] + " ");
                }
                result.insert(0, chunkStr);
            }
            num /= 1000;
            scaleIndex++;
        }

        return result.toString().trim().length() == 0 ? 0 : Integer.parseInt(result.toString().trim());
    }

    private String convertChunk(int num, String[] units, String[] teens, String[] tens) {
        StringBuilder chunk = new StringBuilder();
        int hundreds = num / 100;
        int remainder = num % 100;

        if (hundreds > 0) {
            chunk.append(units[hundreds]).append(" Hundred ");
        }

        if (remainder > 0) {
            if (remainder < 10) {
                chunk.append(units[remainder]);
            } else if (remainder < 20) {
                chunk.append(teens[remainder - 10]);
            } else {
                int ten = remainder / 10;
                int unit = remainder % 10;
                chunk.append(tens[ten]);
                if (unit > 0) {
                    chunk.append(" ").append(units[unit]);
                }
            }
        }

        return chunk.toString().trim();
    }
}