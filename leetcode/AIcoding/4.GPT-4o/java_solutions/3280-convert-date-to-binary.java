class Solution {
    public String convertDateToBinary(String date) {
        String[] parts = date.split("-");
        int day = Integer.parseInt(parts[2]);
        int month = Integer.parseInt(parts[1]);
        int year = Integer.parseInt(parts[0]);

        StringBuilder binaryDate = new StringBuilder();
        binaryDate.append(String.format("%05d", Integer.parseInt(Integer.toBinaryString(year))));
        binaryDate.append(String.format("%04d", Integer.parseInt(Integer.toBinaryString(month))));
        binaryDate.append(String.format("%05d", Integer.parseInt(Integer.toBinaryString(day))));

        return binaryDate.toString();
    }
}