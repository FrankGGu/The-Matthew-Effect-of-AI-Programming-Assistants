public class Solution {

import java.sql.*;

public class Solution {
    public static void main(String[] args) {
        // This method is not used by LeetCode. The actual solution is in the selectData method.
    }

    public static void selectData() {
        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/your_database", "username", "password");
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM Person WHERE id = 1");
            while (rs.next()) {
                System.out.println(rs.getString("name"));
            }
            rs.close();
            stmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
}